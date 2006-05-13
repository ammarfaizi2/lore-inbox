Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWEMOAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWEMOAy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWEMOAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:00:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46764 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932426AbWEMOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:00:53 -0400
Subject: Re: Executable shell scripts
From: Arjan van de Ven <arjan@infradead.org>
To: Douglas McNaught <doug@mcnaught.org>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
In-Reply-To: <87r72yi346.fsf@suzuka.mcnaught.org>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	 <1147517786.3217.0.camel@laptopd505.fenrus.org>
	 <20060513110324.10A38146AF@hunin.borkware.net>
	 <1147518432.3217.2.camel@laptopd505.fenrus.org>
	 <87r72yi346.fsf@suzuka.mcnaught.org>
Content-Type: text/plain
Date: Sat, 13 May 2006 16:00:49 +0200
Message-Id: <1147528850.3217.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Every Unix I've ever seen works this way.  It'd be nice to have
> unreadable executable scripts, but no one's ever done it.


hmm I'm less convinced of what that would bring anyone. Just like you
can get to the content of elf files anyway, you can get to the content
of the script (just attach a debugger for example)

execute == read + action


