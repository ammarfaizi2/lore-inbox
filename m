Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSJFOqj>; Sun, 6 Oct 2002 10:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSJFOqj>; Sun, 6 Oct 2002 10:46:39 -0400
Received: from due.stud.ntnu.no ([129.241.56.71]:45795 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S261631AbSJFOqi>;
	Sun, 6 Oct 2002 10:46:38 -0400
Date: Sun, 6 Oct 2002 16:36:36 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006143636.GA30441@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws> <20021006105917.GB13046@stud.ntnu.no> <20021006122415.GE31878@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006122415.GE31878@pegasys.ws>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz:
> Are all those processes hanging because of NFS?  If so, i'd
> start by looking at the mount options as i said before.  I'd
> also look into the network and fileserver because something
> is wrong.  In my experience Solaris behaved the same way.

They're hanging because I killed of the autofs-processes, and
started it again. (And then every NFS-share is remounted).
So, basically, they're all hanging there, and will keep 
hanging there 'till I boot the machine. 

-- 
Thomas
