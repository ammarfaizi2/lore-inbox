Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWECXsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWECXsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWECXsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:48:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:54857 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWECXse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:48:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A7JzoKmET98sbVLABXfKhA5kzcJQ1lL839eD6A+VccBQmLD7yyxPOXzfhjTPd1WyclySXD1fBsn7fsmGdBwHIBVVhqxgR4q4zKEErKF2LD5JPChV1kopaseoIGfnQHBIFsspZPuvmJPOLJyI2oo1fqBmlnPN/YgQLYevgTdbQJA=
Message-ID: <6934efce0605031648k56eafc98heb3070e0296dd357@mail.gmail.com>
Date: Wed, 3 May 2006 16:48:32 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <625fc13d0605031617v44c2b278kbf12e00781f55ae6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
	 <6934efce0605031154l225caee8yc217c6e63c0dd441@mail.gmail.com>
	 <625fc13d0605031617v44c2b278kbf12e00781f55ae6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erm, why was one built on NAND and one on NOR?  You're comparing
> apples to oranges now.

The assumption I'm making is that if you don't use XIP that NAND
becomes an economically attractive and technically feasible option to
store the code.  The idea was to dive into the tradeoffs of the
options.  It reflects what I believe is the reality of what design
decisions are being looked at by customers of my current employer.

Comparing apples and oranges is appropriate when one is investigating
spherical fruits :)
