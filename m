Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWHEDlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWHEDlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 23:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWHEDlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 23:41:06 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:16021 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422726AbWHEDlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 23:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dj6Trc6ehtPMRarTkaG3GykXU66WsxjU0+LngBwXp0i4FgNzOrLLHYD1FKRwu7mY8w4HPKW2T2FGKY4HaNLUCaFW+Ne5Yqz9hEH6XDnpegWzlFCl4dMg/mpVG1zaPtPNMbErsyR0+baGINRisS72/yqNjIZ+oClev1eZQUlhsUg=
Message-ID: <44D41361.7030701@gmail.com>
Date: Sat, 05 Aug 2006 12:41:21 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.18-rc2-mm1] libata cdroms not automounted
References: <20060803011633.13338417@werewolf.auna.net> <44D2F744.70302@gmail.com> <44D3D299.3010607@gmail.com>
In-Reply-To: <44D3D299.3010607@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Tejun Heo wrote:
>> polling for SCSI cdroms for that reason.  I seem to recollect the 
>> polling was done by some gnome daemon, not sure which though.
> 
> probably gnome-volume-manager

Yeah, that sounds about right.

-- 
tejun
