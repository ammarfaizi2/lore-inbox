Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRGaSNz>; Tue, 31 Jul 2001 14:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRGaSNq>; Tue, 31 Jul 2001 14:13:46 -0400
Received: from boreas.isi.edu ([128.9.160.161]:36600 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S269390AbRGaSNb>;
	Tue, 31 Jul 2001 14:13:31 -0400
To: Riley Williams <rhw@MemAlpha.CX>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: OT: Virii on vger.kernel.org lists 
In-Reply-To: Your message of "Tue, 31 Jul 2001 19:02:18 BST."
             <Pine.LNX.4.33.0107311858360.23876-100000@infradead.org> 
Date: Tue, 31 Jul 2001 11:12:44 -0700
Message-ID: <22369.996603164@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>Is there any way we can set up an automatic virus scan of all
>attachments at vger, and have it deal with any virii at source?

	Better than that, simply strip all non-text MIME attachments,
or bounce the messages containing them.  End of story.

					Craig Milo Rogers
