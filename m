Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWDMLBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWDMLBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWDMLBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:01:21 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:17847 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964879AbWDMLBU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:01:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WpvrPGOgpUsqX4Xe388yjXVnRB09lAAO7QEcyr43L/47UXDdMYfmhpnTHbLpag+yNROk/yNysQFdSCalZNQY8w1pNzsiy+kNPF87dl8ubU0QC2wwyrVU5xODYGkKtWfMUfr94wCJyaDy5iAdkobbFlYYPuVCkO6NJpprOmm/7DA=
Message-ID: <6d6a94c50604130401r1a530af9w3a0f751ba26e7806@mail.gmail.com>
Date: Thu, 13 Apr 2006 19:01:19 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Is it a bug of ./include/linux/input.h?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060413105306.GA5751@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
	 <20060413105306.GA5751@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

> Dmitry Torokhov has already fixed that in his tree, a fix should be
> available reasonably soon.
>

Thanks a lot, I'll pull Dmitry's tree to see how to fix it.

Regards,
-Aubrey
