Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTLXSjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTLXSjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:39:35 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:55216
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263775AbTLXSje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:39:34 -0500
Date: Wed, 24 Dec 2003 13:39:33 -0500
From: Sean Estabrooks <seanlkml@rogers.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Message-Id: <20031224133933.2d35158c.seanlkml@rogers.com>
In-Reply-To: <200312241341.23523.blaisorblade_spam@yahoo.it>
References: <200312241341.23523.blaisorblade_spam@yahoo.it>
Organization: 
X-Mailer: Sylpheed version 0.9.4-gtk2-20030802 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.103.218.41] using ID <seanlkml@rogers.com> at Wed, 24 Dec 2003 13:37:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 18:20:22 +0100
BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> NEED:
> I have the need to loop mount files containing not plain filesystems,
> but whole disk images.
> 

What does your proposed feature add to the kernel that can't be
accomplished with the "losetup" command and its offset parameter?

Sean
