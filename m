Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSKZLtD>; Tue, 26 Nov 2002 06:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSKZLtD>; Tue, 26 Nov 2002 06:49:03 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:40973 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262828AbSKZLtC>; Tue, 26 Nov 2002 06:49:02 -0500
Date: Tue, 26 Nov 2002 12:56:14 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.49-ac1
Message-ID: <20021126115614.GK29196@louise.pinerecords.com>
References: <20021126035518.GC29196@louise.pinerecords.com> <200211261154.gAQBsdL03336@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211261154.gAQBsdL03336@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > include/asm/io_apic.h: In function `io_apic_modify':
> > include/asm/io_apic.h:128: =01pic_sis_bug' undeclared (first use in this fu=
> 
> Your tree is corrupt, looks like flipped bits (its gone from 'a' to ^A)

Naah, that's just me pasting text into joe and forgetting to fix it up
afterwards. :)

T.
