Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSLQIgP>; Tue, 17 Dec 2002 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSLQIgO>; Tue, 17 Dec 2002 03:36:14 -0500
Received: from twin.jikos.cz ([217.11.236.59]:63980 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S261238AbSLQIgO>;
	Tue, 17 Dec 2002 03:36:14 -0500
Date: Tue, 17 Dec 2002 09:44:09 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org
cc: "Grover, Andrew" <andrew.grover@intel.com>
Subject: SMIC and IPMI (was: [ACPI] Metolious hardware-sensors-using-ACPI
 specs)
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5AB@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.50.0212170938180.1285-100000@twin.jikos.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5AB@orsmsx119.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Grover, Andrew wrote:

> The machines that care about manageability (servers) appear to be entirely
> disjoint from the ones that have thermal zones (and, servers use IPMI),

Talking about IPMI - is there anyone working on SMIC interface to IPMI
driver written by Corey Minyard? (http://home.attbi.com/~minyard). He
isn't working on it personally as he told me, because he doesn't have such
HW.

I've just downloaded specification from intel and can start working on it
after I finish my other projects, but I am asking firstly, to avoid
implementing it if someone is currently doing it.

--
JiKos.

