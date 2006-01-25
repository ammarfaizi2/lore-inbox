Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWAYRTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWAYRTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWAYRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:19:24 -0500
Received: from webmail.terra.es ([213.4.149.12]:33673 "EHLO
	csmtpout3.frontal.correo") by vger.kernel.org with ESMTP
	id S1750858AbWAYRTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:19:23 -0500
Date: Wed, 25 Jan 2006 18:18:00 +0100 (added by postmaster@terra.es)
From: <grundig@teleline.es>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, axboe@suse.de, schilling@fokus.fraunhofer.de,
       rlrevell@joe-job.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060125181847.b8ca4ceb.grundig@teleline.es>
In-Reply-To: <43D7AF56.nailDFJ882IWI@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de>
	<43D7AF56.nailDFJ882IWI@burner>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 25 Jan 2006 18:03:18 +0100,
Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:

> Guess why cdrecord -scanbus is needed.
> 
> It serves the need of GUI programs for cdrercord and allows them to retrieve 
> and list possible drives of interest in a platform independent way.

But this is not neccesary at all, since linux platform already provides ways to
retrieve and list possible drives....
