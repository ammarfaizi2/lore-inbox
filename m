Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTKPNRs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTKPNRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:17:48 -0500
Received: from smtp13.eresmas.com ([62.81.235.113]:46488 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S262758AbTKPNRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:17:46 -0500
Message-ID: <3FB778ED.1090707@wanadoo.es>
Date: Sun, 16 Nov 2003 14:17:33 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, warren@togami.com
Subject: Re: Status of dpt_i2o? (Adaptec 2110S)
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Togami wrote:

> What is the status of dpt_i2o with the 2.6 kernel?  Has any work been
> done to improve its non-x86 arch compatibility?
> 
> I am concerned here because my new servers have Adaptec 2110S SCSI RAID
> controllers less than 6 months old, and it appears that as of the next
> release of Fedora Core I will no longer be able to upgrade my servers
> due to the lack of dpt_i2o driver.
> 
> I am also disheartened that the dpt_i2o driver never did seem to work in
> alternate architectures.

my last notes about it are:

o dpt_i2o
 - manufacturer: ADAPTEC
 - kernel: 2.4.5
 - latest: 2.5.0
 - arch: i386 ia64 alpha sparc x86_64(amd64)
 - features: highmem_io 64_bit_SG
 - maintainer: <Mark_Salyzyn_AT_adaptec.com>
 - url: http://linux.adaptec.com

-- 
HTML mails are going to trash automagically

