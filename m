Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUAJSBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUAJR7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:59:41 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:36241 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S265304AbUAJR6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:58:38 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Scott Feldman <scott.feldman@intel.com>
Subject: Re: 2.4.24 eth0: TX underrun, threshold adjusted.
References: <x665fkb59o@gzp> <1073746559.752.44.camel@tux.rsn.bth.se>
	<x6oetb66uu@gzp> <1073757207.752.50.camel@tux.rsn.bth.se>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sat, 10 Jan 2004 18:58:32 +0100
Message-ID: <x6d69r65yv@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Josefsson <gandalf@wlug.westbo.se>:

| > | This isn't really an error, it's an indicator that the pci-bus doesn't
| > | really keep up, then the NIC has to increase the threshold (it tries to
| > | start sending the packet out before it's fully transferred from main
| > | memory to the NIC, it hopes the rest of the packet will have been
| > 
| > Funny because I have changed the mobo/cpu/ram from P3 to P4. Maybe
| > its related to that change?
| 
| Most probably.

This means the old P3 performs better on PCI than the new P4? :-)
Anyway I haven't noticed any incerase in speed... Hello intel.

