Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSLDDnQ>; Tue, 3 Dec 2002 22:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSLDDnQ>; Tue, 3 Dec 2002 22:43:16 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:39335 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S266868AbSLDDnQ>; Tue, 3 Dec 2002 22:43:16 -0500
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bincancels in linux.kernel
References: <fa.d6sj37v.97gj3h@ifi.uio.no> <fa.frmc8vv.pkcm2i@ifi.uio.no>
In-Reply-To: <fa.frmc8vv.pkcm2i@ifi.uio.no> ("Miquel van Smoorenburg"'s
 message of "Tue, 3 Dec 2002 10:19:48 GMT")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Tue, 03 Dec 2002 19:50:42 -0800
Message-ID: <ylr8cyzbl9.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Honest Recruiter,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> writes:

> The big problem is when multiple gateways to news exist in multiple
> hierarchies. News servers accept a certain message only once - and the
> only thing that is looked at is the message-id.

> So if your news server gets fa.linux.kernel and linux.kernel, half of
> the articles will end up in the first group and half of the articles in
> the second.

fa.linux.kernel rewrites the message IDs.  I believe that linux.kernel
does as well.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
