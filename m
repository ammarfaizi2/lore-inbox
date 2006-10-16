Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWJPSUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWJPSUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJPSUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:20:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:395 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422755AbWJPSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:20:37 -0400
Message-ID: <df1ef2450610161120h8accfb7h85830bdc85dd88cb@mail.gmail.com>
Date: Mon, 16 Oct 2006 14:20:36 -0400
From: "Andrew Moise" <chops@demiurgestudios.com>
To: "Patro, Sumant" <Sumant.Patro@lsi.com>
Subject: Re: Frequent RESETs with 2.6.16 megaraid_sas
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0631C836DBF79F42B5A60C8C8D4E82297502D6@NAMAIL2.ad.lsil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0631C836DBF79F42B5A60C8C8D4E82297502D6@NAMAIL2.ad.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/06, Patro, Sumant <Sumant.Patro@lsi.com> wrote:
> The line you picked is a critical bug fix. However, the patch also
> contains code to handle new FW states. I would recommend you to apply
> the whole patch.

  Okay, thanks.  Are there currently any plans to push this bugfix
into the -stable kernel branches?
