Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWCLUnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWCLUnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCLUnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:43:21 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:46504 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751757AbWCLUnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:43:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Gx5oS+8ueWvbVGsdDsXWOu/fRX2Jc7675qPeSq0HY0wcJpi4WQ6JdB3ef/+FrJ3a534JmaUa7CSPR0SWkrq50ToLaaJfRKV+93r79ZRYxoqoJng9NkDwyRA6ljxjomLW+R8x+EkF1+9OfOSSw1ZS6CNCnLCHO4HmUbHt4E2ncec=
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: j4K3xBl4sT3r <jakexblaster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 12:43:14 -0800
Message-Id: <1142196194.3580.3.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 15:15 -0300, j4K3xBl4sT3r wrote:

> Any suggestion? The config of my kernel includes ACPI, APM, ALSA, Elf
> a.out and misc binaries as build-in, ext2 and ext3 built-in, Netfilter
> as module (tried also as built-in), VESA VGA / Framebuffer, SCSI and
> IDE drivers, USB mass storage.

Could you provide the output from lsmod and dmesg?

--
Chris Largret <http://daga.dyndns.org>

