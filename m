Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVDXQLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVDXQLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 12:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVDXQKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 12:10:55 -0400
Received: from weed.lut.ac.uk ([158.125.1.226]:53480 "EHLO weed.lut.ac.uk")
	by vger.kernel.org with ESMTP id S262351AbVDXQKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 12:10:43 -0400
Message-ID: <426BC4C9.8060403@lboro.ac.uk>
Date: Sun, 24 Apr 2005 17:09:45 +0100
From: "A.E.Lawrence" <A.E.Lawrence@lboro.ac.uk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <de@axiros.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Primary ide disk inaccessible. 2.6.11.7, x86_64
References: <426B8D14.9050408@lboro.ac.uk> <064085cb719a246d17e19bde8dfcaee2@axiros.com>
In-Reply-To: <064085cb719a246d17e19bde8dfcaee2@axiros.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: 13884a2d58f8f4bc7e50ef16bad8e2dd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> On 24.04.2005, at 14:12, A.E.Lawrence wrote:
> 
>> I have 4 sata, 1 scsi and 1 ata hard disks attached to an Asus A8N-SLI.
>> The primary ata disc (connected to ide0) is inaccessible:
> 
> 
> Are you booting from PATA or SATA?

Sata. And as I noted, it has worked booting from sata in one version of 
a 2.6.n kernel embedded in a debian install disk. Unless I am doing 
something stupid in the configuration, there seems to be a clear bug 
here to be tracked down.

ael
