Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWDCTpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWDCTpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWDCTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:45:03 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:3016 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964856AbWDCTpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:45:01 -0400
Date: Mon, 3 Apr 2006 15:45:00 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Convertingpcnet32 driver to NAPI.
Message-ID: <20060403194500.GB4689@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know of any reason it wouldn't be possible to convert
pcnet32 to NAPI?  It looks to me like it has the required features for
it.

My job for the next few days is to try and do this.  I hope it works.

Len Sorensen
