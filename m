Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbREFIMz>; Sun, 6 May 2001 04:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135186AbREFIMq>; Sun, 6 May 2001 04:12:46 -0400
Received: from gate.in-addr.de ([212.8.193.158]:37382 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S135181AbREFIMc>;
	Sun, 6 May 2001 04:12:32 -0400
Date: Sun, 6 May 2001 10:12:17 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re:  [patch] 2.4 add suffix for uname -r
Message-ID: <20010506101217.H3988@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan> <3437.989135106@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <3437.989135106@ocs3.ocs-net>; from "Keith Owens" on 2001-05-06T17:45:06
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-05-06T17:45:06,
   Keith Owens <kaos@ocs.com.au> said:

> You already have a working kernel which you want to rename to use as a
> backup version.  Changing EXTRAVERSION and recompiling builds a new
> kernel and adds uncertainty about whether the kernel still works - did
> you change anything else before recompiling? 

You assign a new EXTRAVERSION to the new kernel you are building, and keep the
old kernel at the old name.

Problem solved.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

