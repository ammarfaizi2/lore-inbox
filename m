Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279852AbRKAXCH>; Thu, 1 Nov 2001 18:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279845AbRKAXBr>; Thu, 1 Nov 2001 18:01:47 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:64007 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279846AbRKAXBl>; Thu, 1 Nov 2001 18:01:41 -0500
Message-ID: <3BE1D439.8A5C81AE@namesys.com>
Date: Fri, 02 Nov 2001 02:01:13 +0300
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net> <20011101130721.D16554@lynx.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> As a note to whoever at namesys created the reiserfs patch to add the
> "notail" flag (overloading the "nodump" flag).  I would much rather
> that a new "notail" flag be allocated for this.  I will contact Ted
> Ted Ts'o to get a flag assigned.  This will avoid any problems in the
> future, and may also be useful at some time for ext2.

Sounds correct to do to me.

Hans
