Return-Path: <linux-kernel-owner+w=401wt.eu-S1760836AbWLJPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760836AbWLJPHU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 10:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760966AbWLJPHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 10:07:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33509 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760836AbWLJPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 10:07:19 -0500
In-Reply-To: <20061208125851.842562f5.akpm@osdl.org>
Subject: Re: -mm merge plans for 2.6.20
To: Andrew Morton <akpm@osdl.org>
Cc: David Safford <safford@us.ibm.com>, kjhall@linux.vnet.ibm.com,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Serge E Hallyn <zohar@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OF89BC425B.CE80E69A-ON85257240.004D0706-85257240.0053AFE1@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Sun, 10 Dec 2006 10:07:20 -0500
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 12/10/2006 10:07:21
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote on 12/08/2006 03:58:51 PM:

> > >  Shall hold in -mm.
> > Why?
>
> They're on hold awaiting further development and awaiting a
merge/no-merge
> They're not causing me any trouble.

Thank you!  We are getting ready to re-release EVM as an integrity
provider. As this version of EVM will not be using the LSM hooks,
which mailing list should we be posting the code?

As for SLIM, we will be addressing Stephen's comments and
submitting changes as necessary shortly thereafter.

Mimi Zohar

