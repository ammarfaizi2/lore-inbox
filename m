Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130404AbQJ1BD5>; Fri, 27 Oct 2000 21:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130710AbQJ1BDh>; Fri, 27 Oct 2000 21:03:37 -0400
Received: from proxy.jakinternet.co.uk ([212.41.43.4]:47628 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S130404AbQJ1BDa>; Fri, 27 Oct 2000 21:03:30 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Jeff V. Merkey
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk> <648.39f967c2.1f52d@trespassersw.daria.co.uk> <20001027105109.B5628@vger.timpanogas.org>
Subject: Re: pcmcia in test10pre6
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <2e99.39f9d427.d8a80@trespassersw.daria.co.uk>
Date: Fri, 27 Oct 2000 19:14:47 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20001027105109.B5628@vger.timpanogas.org>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:

JVM> Grab the pcmcia off sourceforge.  It seems to build and work.  The stuff 
JVM> in 2.4 at present is still somewhat broken.  I worked on this until 2:00
JVM> last night getting it to build with 2.4.  

Couldn't get 3.1.21 to build (you using something later from CVS ?). [
CONFIG_X86_L1_CACHE_SHIFT not defined in the right places].

Droping the test5 modules/drivers into the pcmcia modules directory
works fine. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
