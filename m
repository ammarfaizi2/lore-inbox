Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTFPS3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTFPS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:29:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16547 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264099AbTFPS3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:29:10 -0400
Date: Mon, 16 Jun 2003 11:41:34 -0700
From: Greg KH <greg@kroah.com>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sensors patch 2.5.71
Message-ID: <20030616184134.GB25585@kroah.com>
References: <5.1.0.14.2.20030615125117.00af6428@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030615125117.00af6428@pop.t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 01:12:03PM +0200, Margit Schubert-While wrote:
> Patch for adm1021
> This corrects temp reporting and a major error whereby
> "alarms" and "die_code" were being put though the "TEMP" macro.
> Compiled but don't have the hardware to test.
> Greg, can you push ?

Applied, thanks.

greg k-h
