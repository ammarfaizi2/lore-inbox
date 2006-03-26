Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWCZD2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWCZD2D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWCZD2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:28:01 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:12048 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751331AbWCZD2A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:28:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YqOdDLtADmwBO95VnjQzLW0RgZJ9fjhCUDSkcfGADVi6juJr6opk/jmSLwle/U9p+rPLbHyqgltjTrM0jbj4Zss9WFD6py6RBs6bEZwYcX/AS5Al3Pp1yzUWT9vKk2K0ZJ0sxHFjREMQEqdqYMkCvkyesVgbRUsQRRPs5axQonc=
Message-ID: <5b5833aa0603251927u3b29e99fo5c4abde49ad6d08f@mail.gmail.com>
Date: Sat, 25 Mar 2006 23:27:59 -0400
From: "Anderson Lizardo" <anderson.lizardo@gmail.com>
To: mikado4vn@gmail.com
Subject: Re: Virtual Serial Port
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4425FB22.7040405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442582B8.8040403@gmail.com>
	 <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
	 <4425FB22.7040405@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/06, Mikado <mikado4vn@gmail.com> wrote:
> My purpose is to provide serial interfaces for debugging. My real box
> acts as remote host connecting to VMWare box by a *virtual* serial cable
> so that I can set up a debugging environment.

Have you tried using software-based serial snoopers? See e.g.
http://freshmeat.net/snooper and
http://packages.debian.org/unstable/comm/snooper. Haven't tried any of
these but they seem to do what you describe.

Regards,
--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
