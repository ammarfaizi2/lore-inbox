Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJZKXK>; Sat, 26 Oct 2002 06:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJZKXK>; Sat, 26 Oct 2002 06:23:10 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:18444 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261907AbSJZKXK>; Sat, 26 Oct 2002 06:23:10 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Sun, 20 Oct 2002 16:16:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021020141647.GB6280@elf.ucw.cz>
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org> <20021017120526.GC6014@TK150122.tuwien.teleweb.at> <20021017122056.GB13573@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017122056.GB13573@think.thunk.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ah, ok... I thought that things work like this: the capabilities support
> > already is in the kernel, and to give an app a particular capability,
> > one has to add a particalar extended attribute to the application
> > executable. So I'm wrong here it seems?
> 
> First of all, you can't use a standard user extended attribute, since
> anyone with write access to the file will be allowed to set the
> extended attribute.  This isn't good if you're going to be granting

What are extended attributes good for, then?
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
