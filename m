Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSHDRRy>; Sun, 4 Aug 2002 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318163AbSHDRRy>; Sun, 4 Aug 2002 13:17:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39891 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318162AbSHDRRx>;
	Sun, 4 Aug 2002 13:17:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sun, 4 Aug 2002 13:19:05 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <20020803.173530.35650310.davem@redhat.com> <15692.37018.693984.745251@napali.hpl.hp.com>
In-Reply-To: <15692.37018.693984.745251@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041319.05210.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 10:25 pm, David Mosberger wrote:
> >>>>> On Sat, 03 Aug 2002 17:35:30 -0700 (PDT), "David S. Miller"
> >>>>> <davem@redhat.com> said:
>
>   DaveM>    From: Hubertus Franke <frankeh@watson.ibm.com> Date: Sat,
>   DaveM> 3 Aug 2002 17:54:30 -0400
>
>   DaveM>    The Rice paper solved this reasonably elegant. Reservation
>   DaveM> and check after a while. If you didn't use reserved memory,
>   DaveM> you loose it, this is the auto promotion/demotion.
>
>   DaveM> I keep seeing this Rice stuff being mentioned over and over,
>   DaveM> can someone post a URL pointer to this work?
>
> Sure thing.  It's the first link under "Publications" at this URL:
>
> 	http://www.cs.rice.edu/~jnavarro/
>
>   --david

Also in this context:

"Implemenation of Multiple Pagesize Support in HP-UX"
http://www.usenix.org/publications/library/proceedings/usenix98/full_papers/subramanian/subramanian.pdf

"General Purpose Operating System Support for Multiple Page Sizes"
htpp://www.usenix.org/publications/library/proceedings/usenix98/full_papers/ganapathy/ganapathy.pdf

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
