Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTLCPrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTLCPrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:47:00 -0500
Received: from holomorphy.com ([199.26.172.102]:11726 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264605AbTLCPq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:46:59 -0500
Date: Wed, 3 Dec 2003 07:46:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t11 /proc/<xserver pid>/status question (VmLck > 4TB)
Message-ID: <20031203154653.GU8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Zwickel <martin.zwickel@technotrend.de>,
	linux-kernel@vger.kernel.org
References: <20031203161505.475f1bad.martin.zwickel@technotrend.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203161505.475f1bad.martin.zwickel@technotrend.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 04:15:05PM +0100, Martin Zwickel wrote:
> Hi there,
> I have a small question:
> If I look into the "/proc/<xserver pid>/status" file, there is a VmLck with a
> 4TeraByte number.
> Is that normal?

Nope, it's a bug.


-- wli
