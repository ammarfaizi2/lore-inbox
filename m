Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280658AbRKNPal>; Wed, 14 Nov 2001 10:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280655AbRKNPab>; Wed, 14 Nov 2001 10:30:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29456 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280647AbRKNPaS>; Wed, 14 Nov 2001 10:30:18 -0500
Date: Wed, 14 Nov 2001 16:30:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x has finally made it!
Message-ID: <20011114163016.B2976@ralph.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney> <20011113171836.A14967@emma1.emma.line.org> <m34rnyk511.fsf@belphigor.mcnaught.org> <20011113174250.A15774@emma1.emma.line.org> <m3vggeiodb.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m3vggeiodb.fsf@belphigor.mcnaught.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Doug McNaught wrote:

> > Well, he wanted to benchmark everyday use, and disk latency is also an
> > issue for everyday use, of course;
> 
> But it's more a measure of your disk subsystem than your VM efficiency 
> (unless something is badly wrong). 

The matters are:

- "everyday use" (go with fsync() for mail)

- how good does VM cope with - say - "priority write" actions like
  fsync()?

-- 
Matthias Andree
