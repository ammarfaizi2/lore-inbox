Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSFSE7m>; Wed, 19 Jun 2002 00:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317768AbSFSE7l>; Wed, 19 Jun 2002 00:59:41 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:24460 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S317767AbSFSE7k>;
	Wed, 19 Jun 2002 00:59:40 -0400
Subject: Anyone using NFSv4?
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <008001c216c8$d0bfdba0$294b82ce@connecttech.com>
References: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE>
	<200206171900.03955.rwhite@pobox.com> 
	<008001c216c8$d0bfdba0$294b82ce@connecttech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jun 2002 22:59:41 -0600
Message-Id: <1024462781.17191.18.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the CITI group release a new June snapshot of NFSv4
support for Linux. It is a patch against 2.4.18.

http://www.citi.umich.edu/projects/nfsv4/june_2002_rel/index.html

They say, "The current version passes all Connectathon tests, and
interoperates with other implementations".

Currently NFSv2/3 is too insecure for my tastes, I'm greatly looking
forward to the strong authentication, integrity, and privacy that NFSv4
with secure RPC offers. I can envision handy uses for the "pseudo path"
feature of NFSv4 as well.

I was just wondering if anyone (other that CITI) is keeping an eye on
it? Are there any pieces worth merging yet?  Just curious.

Dax Kelson

