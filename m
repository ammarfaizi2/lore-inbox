Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbREHOAV>; Tue, 8 May 2001 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbREHOAO>; Tue, 8 May 2001 10:00:14 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:13985 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S131480AbREHN77>;
	Tue, 8 May 2001 09:59:59 -0400
Date: Tue, 8 May 2001 06:59:54 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Dennis Bjorklund <db@zigo.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: monitor file writes
In-Reply-To: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
Message-ID: <Pine.LNX.4.33.0105080659010.30175-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsof will tell you what files are open and what applications are using
them.

joelja

On Tue, 8 May 2001, Dennis Bjorklund wrote:

> Is there a way in linux to montior file writes?
>
> I have something that is writing to the disk every 5:th second (approx.)
> And I don't know what it is.. In windows I had a small program called
> FileMonitor that where quite good in this situation.
>
> Is there such a program i linux? If not, is it because the kernel does not
> provide this information. Maybe there is needed some new hooks to make it
> possible?
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


