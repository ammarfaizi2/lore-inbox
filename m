Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281449AbRKQXAr>; Sat, 17 Nov 2001 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRKQXAh>; Sat, 17 Nov 2001 18:00:37 -0500
Received: from mail.delfi.lt ([213.197.128.86]:16648 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S281449AbRKQXAW>; Sat, 17 Nov 2001 18:00:22 -0500
Date: Sun, 18 Nov 2001 00:50:28 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Microsoft IE6 is crashing with Linux 2.4.X
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <002501c16e0c$d3800550$f5976dcf@nwfs> <1005854832.2730.1.camel@heat> <000001c16e6c$c29061d0$f5976dcf@nwfs>
 <20011116014528.A22819@vger.timpanogas.org>
In-Reply-To: <20011116014528.A22819@vger.timpanogas.org>
X-Mailer: Mahogany, 0.64.1 'Sparc', compiled for Linux 2.4.14 i686
Message-Id: <20011117230021.A1D938FB3C@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 01:45:28 -0700 "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:

JVM> The mail server was down for over 9 hours today.  Suffice to say if 
JVM> you are using RedHat Seawolf with Sendmail 8.11.X you need to upgrade 
JVM> to 8.12.00 and enable UseMSP=Yes and set up the indirect submission
JVM> methods for smmsp:smmsp.  I used tcpdump and determined that IE6 will 
JVM> send "hidden" emails to addresses at msn.com (they appeared random).  I 
JVM> have no idea why it is doing this, but these emails appeared to contain 
JVM> system level information.  There was also obvious (and very nasty) packet 
JVM> corruption from IE6 that sendmail 8.11.X does not handle very well at all
JVM> whe it gets these corrupted packets.  

Just to be sure - do you have latest antivirus updates?

Regards,
Nerijus

