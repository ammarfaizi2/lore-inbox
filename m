Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDUCIl>; Fri, 20 Apr 2001 22:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDUCIV>; Fri, 20 Apr 2001 22:08:21 -0400
Received: from ns1.justnet.com ([64.245.23.22]:33546 "EHLO ns1.justnet.com")
	by vger.kernel.org with ESMTP id <S132039AbRDUCIT>;
	Fri, 20 Apr 2001 22:08:19 -0400
From: Lee Leahu <lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS Inc
To: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
Date: Fri, 20 Apr 2001 21:07:20 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com> <01042020185806.00845@linux> <m34rvjuj3y.fsf@belphigor.mcnaught.org>
In-Reply-To: <m34rvjuj3y.fsf@belphigor.mcnaught.org>
MIME-Version: 1.0
Message-Id: <01042021072007.00845@linux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2001 20:39, you wrote:
> Lee Leahu <lee@ricis.com> writes:
> > would somebody be kind enough to explain why writing to
> > the ntfs file system is extremely dangerous,  and what are the
> > developers doing to make writing to ntfs filesystem safe?
>
> It's dangerous because NTFS is a proprietary format, and the full
> rules for updating it (including journals etc) are known only to
> Microsoft and those that have signed Microsoft NDAs.  If you update it
> incorrectly it gets corrupted and you will lose data.  It's certainly
> possible to reverse-engineer these rules, but very difficult and
> time-consuming.
>
> -Doug

my boss rememebres reading a very indepth article in one of the msdn 
magazines.  i could scan the articles in and compress them and send them to 
the developers. i want to help the ntfs movement on linux.  would somebody be 
willing to teach me the ropes of reverse engineering of software.  i am a 
faster learner, and very interested in reverse engineering of software.

i have access to the msdn library and maganzies and have lot of free time for 
dedicated ntfs code hacking.

-- 
lee@ricis.com,
Open Source + Linux = Freedom
