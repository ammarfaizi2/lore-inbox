Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261636AbSJFO6Y>; Sun, 6 Oct 2002 10:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbSJFO6Y>; Sun, 6 Oct 2002 10:58:24 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:50585 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S261636AbSJFO6X>; Sun, 6 Oct 2002 10:58:23 -0400
Date: Sun, 6 Oct 2002 16:54:50 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Graham Murray <graham@barnowl.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006145450.GB30441@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws> <20021006105917.GB13046@stud.ntnu.no> <m3ptunej1h.fsf@home.gmurray.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ptunej1h.fsf@home.gmurray.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Murray:
> > They won't have any effect on the system, but the load number is
> > insane (we have a 2 CPU intel-boks with a load number of 480)
> > and there's like 200-300 (or more) processes hanging in D-state
> > with they're FD's and stuff.
> That in itself could have an effect on the system. Applications such
> as sendmail and inn can monitor the load average and enter an
> 'overload' state (eg refuse connections) if it gets too high.

Good point, didn't think of that :)

-- 
Thomas
