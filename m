Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTHUL7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTHUL7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:59:54 -0400
Received: from zork.zork.net ([64.81.246.102]:36043 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262639AbTHUL7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:59:52 -0400
To: "John Newbie" <john_r_newbie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe remove request_module("scsi_hostadapter"); from ->
References: <Law14-F60elXDeqoMIO000010f9@hotmail.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "John Newbie" <john_r_newbie@hotmail.com>,
 linux-kernel@vger.kernel.org
Date: Thu, 21 Aug 2003 12:59:46 +0100
In-Reply-To: <Law14-F60elXDeqoMIO000010f9@hotmail.com> (John Newbie's
 message of "Thu, 21 Aug 2003 15:38:38 +0400")
Message-ID: <6uhe4bnrv1.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Newbie" <john_r_newbie@hotmail.com> writes:

> The reason is that scsi subsystem starts before mounting
> root FS, so where we can get modules.conf and insmod ?

Consider IDE systems with SCSI peripherals and SCSI built modular.

