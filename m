Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVJFTGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJFTGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVJFTF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:05:59 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:44813 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751309AbVJFTF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:05:59 -0400
Message-ID: <43457587.6000502@symas.com>
Date: Thu, 06 Oct 2005 12:05:43 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20050925 SeaMonkey/1.1a
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: madhu.subbaiah@wipro.com, linux-kernel@vger.kernel.org
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
References: <1128606546.14385.26.camel@penguin.madhu> <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com>
In-Reply-To: <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Or am I missing something?
>   
Insert obligatory joke about optimizing delay loops... ?

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

