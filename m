Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTAEF37>; Sun, 5 Jan 2003 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbTAEF37>; Sun, 5 Jan 2003 00:29:59 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:56417 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S263228AbTAEF3p>;
	Sun, 5 Jan 2003 00:29:45 -0500
From: <Hell.Surfers@cwctv.net>
To: andre@linux-ide.org, andrew@indranet.co.nz, rms@gnu.org,
       linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 05:37:24 +0000
Subject: RE:Re: Gauntlet Set NOW!
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041745044726"
Message-ID: <0c58a2334050513DTVMAIL7@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041745044726
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It believes in GOD? :-)

Dean McEwan, If the drugs don't work, [sarcasm] take more...[/sarcasm].

On 	Sat, 4 Jan 2003 21:31:39 -0800 (PST) 	Andre Hedrick <andre@linux-ide.org> wrote:

--1041745044726
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sun, 5 Jan 2003 05:31:08 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTAEFYJ>; Sun, 5 Jan 2003 00:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbTAEFYJ>; Sun, 5 Jan 2003 00:24:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26377
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262824AbTAEFYH>; Sun, 5 Jan 2003 00:24:07 -0500
Received: from localhost (andre@localhost)
	by master.linux-ide.org (8.9.3/8.9.3) with ESMTP id VAA17948;
	Sat, 4 Jan 2003 21:31:39 -0800
Date: Sat, 4 Jan 2003 21:31:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: rms@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
In-Reply-To: <635470000.1041743530@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10301042123450.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Sun, 5 Jan 2003, Andrew McGregor wrote:

> By the way, I'm principally a developer of communications standards and 
> hardware, not so much software.

I forgot to mention the template model on each side of the iSCSI protocol
state machine we have developed is agnostic?

Initiator --- Transport --- Target --- Spindle

		TCP			SCSI
		Quads			ATA
		SCI			SATA
		Myrinet			MD
		InfiniBand		LVM
		TELCO			USB
		CARRIER			1394
					SAS
					Fibre Channel

					FLOPPY, for emergencies.

	Create Your Own		Create Your Own

Yeah, I am nutter than a fruitcake, but it works!

This is for Larry McVoy, it is the closest thing you will ever see today
which looks like a disk with an RJ-45 port.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


> --On Saturday, January 04, 2003 18:44:49 -0500 Richard Stallman 
> <rms@gnu.org> wrote:
> 
> >     But sometimes we can't make things free, either because it comes to
> > close      to core IP which we are legally bound to protect, or because
> > it's a derived      work of something we bought and don't ourselves have
> > the right to      redistribute.
> >
> > At this level of generality, I can only say that if the program is to
> > be published as non-free software, it will not be available to people
> > to use in freedom.  Its effect will be to tempt people to give up
> > their freedom.  If I had a choice to develop that program or no
> > program, I would develop no program.
> 
> Here is where we differ.  I do these things because, even though they do 
> not promote software freedom, they can and, I hope, do promote other kinds 
> of freedom in other ways.  I also always look to the maximally free way to 
> do the software parts.  Sometimes it is not possible to acheive the other 
> goals we have and keep the software entirely free.  I think, however, that 
> the freedom given by very inexpensive and unconstrained (that is, free as 
> in speech) telecommunications is somewhat more important than the absolute 
> freedom of the specific software we use to acheive that.  In several cases, 
> we have chosen proprietary solutions where they make the monetary cost to 
> the end user dramatically lower, because one of our target problems is the 
> lack of economic freedom in many parts of the world.  For those with an 
> arbitrary hardware budget, there are or soon will be interoperable free 
> software alternatives.  We make sure of that.  We make sure we use open 
> standards with no closed extensions, so as to make sure this continues.
> 
> > I would rather look for constructive alternatives than just criticize.
> > In such a situation, I would look for a way to make the program free.
> 
> I'm often focused on the case where the total hardware + software cost is 
> the key factor between user of any communications and user of no 
> communications.  I use free or partly free software wherever I can, because 
> I am not hostile to that goal, but that is not my overriding concern.
> 
> I am also concerned that some of the zealots in the free software, not 
> necessarily including yourself Richard, do not set precedents in the courts 
> that, while possibly reinforcing the particular technicality of the GPL, 
> undermine the freeness of kinds of speech other than software, such as 
> scientific communication, cultural artefacts and political discussion.  In 
> the long run that would be worse for freedom in general.
> 
> > This scenario is too general to get started on that.  (I explained in
> > another message how the term "intellectual property" tends to obscure
> > important distinctions; this is an example.)  In any specific case
> > there is likely to be some way.
> 
> Here I'm using that term in the sense of 'copyrighted (and possibly 
> patented) compilable information and its documentation', covering both 
> software and hardware designs.  If I were to use it to cover anything else 
> I'd be more specific, as is common usage where I come from.  I do 
> understand the ambiguity and hidden conflations behind the term; I have 
> been involved in both trademark and patenting (of hardware; software 
> patents are evil, no question) work, and I'm cited as an inventor on one 
> patent, so I have some firsthand experience.
> 
> > If there is no easy way to make the same program free, there may be a
> > harder way.  People who value freedom strongly sometimes choose the
> > hard path to freedom rather than the easy path that extends
> > non-freedom.  That is how we extend freedom.
> 
> I'm principally concerned with other sorts of freedom, while attempting to 
> forward the cause of software freedom to the extent I can, and attempting 
> never to advance the cause of any sort of non-freedom.  It isn't easy at 
> all, believe me.
> 
> > As an ultimate fallback, there is surely some other job you could do
> > instead.
> 
> I could go back to being a musician or a scientist.  There are freedom 
> issues there, too, believe me.  And I'd still be debating free software, 
> because in those fields it's important too.  It would certainly be easier 
> to tread the path of free software purity in those fields, but I suspect it 
> would make less long-term impact for me to do so.
> 
> > I have no opinion yet about what Andre said, because I cannot form a
> > clear picture of what he plans to do; I don't know whether it would
> > violate the GPL, or whether the issue would involve the FSF.  We do
> > not enforce the GPL for Linux in any case; that is the responsibility
> > of the copyright holders of Linux.
> 
> I'm glad to hear that.  I'm also glad that the zealot who started the 
> thread that has us talking about this does not appear to be one of those 
> copyright holders; I suspect most of them have more sense.
> 
> Andrew
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1041745044726--


