Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLBSOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTLBSOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:14:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27662
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262694AbTLBSO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:14:27 -0500
Date: Tue, 2 Dec 2003 10:14:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, rddunlap@osdl.org
Subject: Re: [2.6] Missing L2-cache after warm boot
Message-ID: <20031202181421.GS1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Jochen Hein <jochen@jochen.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, rddunlap@osdl.org
References: <87ptf8bpnd.fsf@echidna.jochen.org> <20031201113300.7eb9bb7f.rddunlap@osdl.org> <87ekvnjr66.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekvnjr66.fsf@echidna.jochen.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 02:16:33PM +0100, Jochen Hein wrote:
> I've now restricted memory with mem=190m (has 196m installed).  I'll
> keep investigating.

What good does cutting 6MB off from use?
