Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTJOPHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTJOPHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:07:35 -0400
Received: from mail.midmaine.com ([66.252.32.202]:41152 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S263380AbTJOPH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:07:28 -0400
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
X-Eric-Conspiracy: There Is No Conspiracy
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl> <87wub6o8vl.fsf@loki.odinnet>
	<16269.25149.823749.941199@laputa.namesys.com>
From: Erik Bourget <erik@midmaine.com>
Date: Wed, 15 Oct 2003 11:06:12 -0400
In-Reply-To: <16269.25149.823749.941199@laputa.namesys.com> (Nikita
 Danilov's message of "Wed, 15 Oct 2003 19:05:33 +0400")
Message-ID: <87oewiv8uz.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> writes:

> Erik Bourget writes:
>  > Seriously, though, (and getting off the topic), has anyone started to use
>  > reiser4 in a high-load environment?  I've got a mail system that shoots a
>  > few million messages through it every day and a filesystem that's faster
>  > with creating and deleting tons of ~4kb qmail queue files (with data
>  > journaling!)  would be verrry innnteresting.
>
> Please, don't use reiser4 in production environments. It is still in the
> late debugging stage. Stay tuned, as they say. :)

What?  It's too late, I already switched the storage to the kernel 2.4 NTFS
write driver, LVM'd wiht reiser4!  arrrrrg ;D

- Erik

