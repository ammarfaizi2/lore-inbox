Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270799AbUJUSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270799AbUJUSwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbUJUSuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:50:04 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:9191 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270800AbUJUSnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:43:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Dmce8Wfdu0Y8b6slz1UwMk/0DEWeac3MBZ21wW/uHVdk2s6KqC5vOpax3crQUwQ20t3+ddRQREZGwy211tyRl7nlPXIrHTuS5zflYR4x4l8joggm+k91okT8Sx8QXbsFg95NoYckSHsTEuq+e3MTZcqQy9N4RljusVVu7CISmZ0=
Message-ID: <58cb370e041021114374bb749f@mail.gmail.com>
Date: Thu, 21 Oct 2004 20:43:32 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: ATA/133 Problems with multiple cards
Cc: James Stevenson <james@stev.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200410201623.21321.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
	 <200410201623.21321.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen <hpj@urpla.net> wrote:
 
> Hmm, I'm running 3 TX2/100 (even with different revisions) without
> big problems here:
> 
> 00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
 
lspci -xxx ?
