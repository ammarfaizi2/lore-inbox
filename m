Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWBPMNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWBPMNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBPMNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:13:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59871 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030374AbWBPMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:13:40 -0500
Subject: Re: Questions about pthread
From: Arjan van de Ven <arjan@infradead.org>
To: Revital Eres <revitale@forescout.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5AF1F1D1E5A5D6439B308F35EA4603F50867C5@sol.fsd.forescout.com>
References: <5AF1F1D1E5A5D6439B308F35EA4603F50867C5@sol.fsd.forescout.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 13:13:36 +0100
Message-Id: <1140092017.4117.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 14:10 +0200, Revital Eres wrote:
> Hello,
> I understand that every system call is a cancellation point for pthreads. My question is how can I avoid this to happen; meaning- to forbid the cancellation point in the system call wrapper. (I call a system call from a cleanup function that is just been cancelled) 


this is not the right mailing list for this question; you're much better
off asking this on one of the glibc mailing lists....


