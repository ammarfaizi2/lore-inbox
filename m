Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRKMTYW>; Tue, 13 Nov 2001 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRKMTYM>; Tue, 13 Nov 2001 14:24:12 -0500
Received: from [217.9.226.246] ([217.9.226.246]:9088 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S278522AbRKMTYJ>; Tue, 13 Nov 2001 14:24:09 -0500
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20011113121022.L1778@lynx.no>
Date: 13 Nov 2001 21:21:11 +0200
Message-ID: <87r8r2tr2w.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andreas" == Andreas Dilger <adilger@turbolabs.com> writes:

Andreas> The only reason (AFAICS) for putting the return type on a
Andreas> separate line is the (ancient) ansi2knr script, which just

or searching for definitions with grep ^foo ...


