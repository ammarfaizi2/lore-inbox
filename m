Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269929AbRHJPbr>; Fri, 10 Aug 2001 11:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269928AbRHJPbi>; Fri, 10 Aug 2001 11:31:38 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:36829 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S269929AbRHJPb1>;
	Fri, 10 Aug 2001 11:31:27 -0400
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] [RFC] /proc/ksyms change for IA64 (fwd)
In-Reply-To: <200108021242.HAA02573@fsgi055.americas.sgi.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 10 Aug 2001 17:31:32 +0200
In-Reply-To: Jack Steiner's message of "Thu, 2 Aug 2001 07:42:45 -0500 (CDT)"
Message-ID: <d3n158ue23.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jack" == Jack Steiner <steiner@sgi.com> writes:

Jack> I know that at some point we need to convert to native builds
Jack> but right now we dont have sufficient bigsur/lion boxes to do
Jack> that.

Jack> We have not seen any problems with the compiler we are using -
Jack> at least we have not attributed a problem to the compiler.

Jack> Should we upgrade to gcc3.0 yet???

Probably not yet. I would stick to gcc-2.96 based on what you can find
in Red Hat's (or one of the other distributions') ia64 SRPMS.

Jes
