Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUBXQDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUBXQDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:03:50 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:53647 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S262193AbUBXQDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:03:49 -0500
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why are 2.6 modules so huge?
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
	<403B72C2.1010705@didntduck.org>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 24 Feb 2004 11:03:46 -0500
In-Reply-To: <403B72C2.1010705@didntduck.org> (Brian Gerst's message of
 "Tue, 24 Feb 2004 10:50:26 -0500")
Message-ID: <9cfu11gjwgt.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> writes:

>
> You probably have debugging config options enabled (ie CONFIG_DEBUG_INFO).
>

Duh.  Thanks.
Ian


