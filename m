Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267958AbTAKSoW>; Sat, 11 Jan 2003 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTAKSoW>; Sat, 11 Jan 2003 13:44:22 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:36004
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267958AbTAKSoV>; Sat, 11 Jan 2003 13:44:21 -0500
Message-ID: <3E2067FE.4060803@redhat.com>
Date: Sat, 11 Jan 2003 10:52:46 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030109
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com> <20030111110717.A24094@infradead.org>
In-Reply-To: <20030111110717.A24094@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> I think it should be updated.  There is no released glibc or stable kernel
> with that number yet.

Actually, we've included the support already in some published code.  If
you want to complain to somebody about this, do it to the person who is
responsible for distributing this code.  His email address is

   torvalds@transmeta.com

Make sure you react with the same nastiness as if I would have made the
decision, OK?

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

