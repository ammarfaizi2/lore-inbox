Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSLFThW>; Fri, 6 Dec 2002 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSLFThW>; Fri, 6 Dec 2002 14:37:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33284 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265677AbSLFThV>;
	Fri, 6 Dec 2002 14:37:21 -0500
Date: Fri, 6 Dec 2002 20:44:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, com.ibm@arndb.de,
       idrys@gmx.de
Subject: Re: s390 update.
Message-ID: <20021206194448.GB8008@mars.ravnborg.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	com.ibm@arndb.de, idrys@gmx.de
References: <200212061944.22688.schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212061944.22688.schwidefsky@de.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On fre, dec 06, 2002 at 08:11:04 +0100, Martin Schwidefsky wrote:
> P.S. some of the patches are too big for lkm. I only post the description
>      file on lkm. If anybody needs the patches just send me a mail and I'll
>      forward them.

Privately I sent you some comments about missing FORCE in the
Makefiles. Is it addressed in this set of patches?

	Sam
