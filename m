Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTK3T14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTK3T14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:27:56 -0500
Received: from holomorphy.com ([199.26.172.102]:41671 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264959AbTK3T1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:27:55 -0500
Date: Sun, 30 Nov 2003 11:27:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130192751.GM8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.085729.-1591395.1.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.085729.-1591395.1.mcmechanjw@juno.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 08:57:26AM -0800, James W McMechan wrote:
> I have a test program much shorter then the Oops
> If someone wants to work from a Oops I will send
> one, no maintainer was listed and the last Google
> reference is about 2 years back, and it does not
> seem to be about this issue.
> This Oops both 2.4.22 and 2.6.0-test11
> It results from a ARCH=um bugreport and
> I kept making the test program shorter
> This seems silly but one line to Oops?

Please post the oops (run through ksymoops as-needed).


-- wli
