Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRJUWj2>; Sun, 21 Oct 2001 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276872AbRJUWjS>; Sun, 21 Oct 2001 18:39:18 -0400
Received: from ns2.kvikkjokk.net ([195.196.65.62]:22536 "HELO
	ns2.kvikkjokk.net") by vger.kernel.org with SMTP id <S276988AbRJUWjF>;
	Sun, 21 Oct 2001 18:39:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oden Eriksson <oden.eriksson@kvikkjokk.net>
Message-Id: <200110220035.49624@kvikkjokk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Date: Mon, 22 Oct 2001 00:39:35 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15vQWb-00085J-00@the-village.bc.nu>
In-Reply-To: <E15vQWb-00085J-00@the-village.bc.nu>
X-No-Archive: No
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sundayen den 21 October 2001 23.52, Alan Cox wrote:
> > Normal users really don't need to see the startup message spam on boot,
> > unless there is an error (at which point it should be able to present
> > the error to the user).  Any kind of of progress indicator' s really
>
> The big problem is making sure they then see the error, and the previous
> progress information. On a solid hang they might not get it
>
> > more for feedback that the boot is proceeding ok.  The fact the boot
> > sequence isn't even interactive should also be a big hint that it isn't
> > really necessary (except for kernel and driver developers).
>
> You are thinking the small picture not the big one. If you are going to
> graphical in init then you want to make full use of the graphical
> environment to clearly show things like parallel fsck behaviour, what
> servers are starting up (with pretty icons) and to do interactive things
> like starting a rescue shell, going single user, pausing the boot,
> changing run level, interactive boot.
>

Gee, this sounds like Mandrake with candy like "Aurora" and "Linuxconf", I 
prefer the old behaivour though :)

-- 
Oden Eriksson, Jokkmokk, Sweden.
Mandrake Linux release 8.1 (Vitamin) for i586, kernel 2.4.12-3mdk. Uptime: 
18:17
