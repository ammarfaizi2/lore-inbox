Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbTCCRNN>; Mon, 3 Mar 2003 12:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbTCCRNN>; Mon, 3 Mar 2003 12:13:13 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:62164 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268308AbTCCRNM>; Mon, 3 Mar 2003 12:13:12 -0500
Date: Mon, 3 Mar 2003 12:23:40 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030303172339.GE13151@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu> <20030303170924.B3371@namesys.com> <1046708741.6509.5.camel@irongate.swansea.linux.org.uk> <20030303183838.B4513@namesys.com> <20030303165054.GC13151@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303165054.GC13151@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:50:54AM -0500, Jan Harkes wrote:
> Yeah, I actually hit that bug while working on Coda which prompted the
> whole iget5_locked implementation.

Hmm, I seem to be misrepresenting my role with this statement.

Yes, I found the bug in Coda, but the actual iget5_locked implementation
was largely based on the icreate patches from XFS that were sent to me
by Steve Lord.

There was a whole discussion on linux-fsdevel where Alexander Viro,
Anton Altaparmakov, Steve Lord, Christoph Hellwig, Chris Mason, and
probably others which I forgot all gave input and comments which I
merged into the patches before they were submitted to Linus.

Just to give credit where credit is due.

Jan

