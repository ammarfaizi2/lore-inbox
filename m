Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUCIQiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCIQiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:38:15 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.112.162.124]:5907
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S262056AbUCIQiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:38:12 -0500
Message-ID: <404DF2EC.6030701@coplanar.net>
Date: Tue, 09 Mar 2004 11:38:04 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: "Ramy M. Hassan" <ramy@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Advanced storage management ( suggestion )
References: <003801c402ea$44437190$ba10a8c0@ramy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramy M. Hassan wrote:
> I see many people interested in designing of new filesystems for
> different purposes, and one of the common tasks all filesystem designers
> will do is to manage device blocks. 

> 
> If you know of any similar effort, or any technical obstacle I am
> missing , please let me know.

Please take a look at EVMS before you reinvent the wheel here. 
http://evms.sourceforge.net

> 
> Ramy

-- 
Jeremy Jackson
Coplanar Networks
http://www.coplanar.net

