Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUJNUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUJNUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUJNSrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:47:51 -0400
Received: from main.gmane.org ([80.91.229.2]:14753 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267232AbUJNSMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:12:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 14 Oct 2004 13:12:42 -0500
Message-ID: <ckmfiq$rc7$1@sea.gmane.org>
References: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-208.client.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
Cc: linux-ide@vger.kernel.org, kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:
> 
> i seem to have run into an annoying problem with a machine which has
> 3 promise ata/133 card the PDC20269 type.
> 

....

> 
> Does anyone have an explenation of why this can happen ?
> 

Promise cards don't support more than two per machine.  If you can get a
third card to work in PIO mode, consider it an added (but unsupported)
bonus.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

