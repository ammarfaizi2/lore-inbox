Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277005AbRJJVQW>; Wed, 10 Oct 2001 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277410AbRJJVQM>; Wed, 10 Oct 2001 17:16:12 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:22738 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S277005AbRJJVP5>; Wed, 10 Oct 2001 17:15:57 -0400
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Date: 10 Oct 2001 23:16:24 +0200
Organization: Chemnitz University of Technology
Message-ID: <87d73vb3h3.fsf@kosh.ultra.csn.tu-chemnitz.de>
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco> <m27l29tj87.fsf@boreas.yi.org.> <m28zj05j7y.fsf@boreas.yi.org.> <008401c0f20f$4458dec0$643b090a@sulaco> <87het7b428.fsf@kosh.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enrico.scholz@informatik.tu-chemnitz.de (Enrico Scholz) writes:

> | [kernel >=2.4.1; open tray]
> | $ rmmod cdrom
> | $ modprobe cdrom autoclose=0
                               ^ oops, should be a '1' obviously


Enrico

