Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136893AbREJTAS>; Thu, 10 May 2001 15:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136894AbREJTAM>; Thu, 10 May 2001 15:00:12 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:36881 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S136893AbREJTAC>;
	Thu, 10 May 2001 15:00:02 -0400
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-acenic@SunSITE.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: [patch] Acenic tigon 1 support fix
In-Reply-To: <20010430170138.A1085@nemesis.ncsl.nist.gov>
From: Jes Sorensen <jes@sunsite.dk>
Date: 10 May 2001 20:59:24 +0200
In-Reply-To: Olivier Galibert's message of "Mon, 30 Apr 2001 17:01:39 -0400"
Message-ID: <d3eltxt4hf.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olivier" == Olivier Galibert <galibert@pobox.com> writes:

Olivier> A typo prevents the tigon 1 firmware to be included when
Olivier> tigon 1 support is active.  Null pointer dereference in
Olivier> ace_load_firmware-> ace_copy as a result.

Olivier> Patch trivial and even tested (aka, the module loads without
Olivier> oopsing with a tigon 1 inside).

Thanks, I'll put that in the next driver release as well.

Jes
