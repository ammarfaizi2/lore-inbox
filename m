Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRB1PkW>; Wed, 28 Feb 2001 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbRB1PkM>; Wed, 28 Feb 2001 10:40:12 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:4083 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130232AbRB1PkE>; Wed, 28 Feb 2001 10:40:04 -0500
Date: Wed, 28 Feb 2001 12:40:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <linux-cluster@nl.linux.org>
cc: <linux-kernel@vger.kernel.org>, <lwn@lwn.net>
Subject: [ANNOUNCE] linux-cluster list
Message-ID: <Pine.LNX.4.33.0102281238300.5502-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On special request, this message is re-sent with [ANNOUNCE] in
the subject and the non-announce parts removed.  ;)

Feel free to pass this on to whomever you think might be interested.
----
	[on general clustering stuff]
On Tue, 27 Feb 2001, David L. Nicol wrote:
> Is there a good list to discuss this on?  Is this the list?
> Which pieces of clustering-scheme patches would be good to have?

I know each of the cluster projects have mailing lists, but
I've never heard of a list where the different projects come
together to eg. find out which parts of the infrastructure
they could share, or ...

Since I agree with you that we need such a place, I've just
created a mailing list:

	linux-cluster@nl.linux.org

To subscribe to the list, send an email with the text
"subscribe linux-cluster" to:

	majordomo@nl.linux.org


I hope that we'll be able to split out some infrastructure
stuff from the different cluster projects and we'll be able
to put cluster support into the kernel in such a way that
we won't have to make the choice which of the N+1 cluster
projects should make it into the kernel...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


