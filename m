Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289663AbSAOVKu>; Tue, 15 Jan 2002 16:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289667AbSAOVKk>; Tue, 15 Jan 2002 16:10:40 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:53726 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289663AbSAOVK2>; Tue, 15 Jan 2002 16:10:28 -0500
Date: Tue, 15 Jan 2002 13:09:00 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: linux-kernel@vger.kernel.org, <kbuild-devel@lists.sourceforge.net>
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <20020115145324.A5772@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201151308110.24005-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Eric S. Raymond wrote:

> 	* The `vitality' flag is gone from the language.  Instead, the
> 	  autoprober detects the type of your root filesystem and forces
> 	  its symbol to Y.

can you override this autodetect? (it may not be valid if you are building
on one machine for another)

David Lang
