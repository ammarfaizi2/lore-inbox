Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTENHot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTENHot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:44:49 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:34029 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S261169AbTENHoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:44:46 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "jw schultz" <jw@pegasys.ws>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: What exactly does "supports Linux" mean?
Date: Wed, 14 May 2003 08:57:28 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMEONCPAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20030514021210.GD30766@pegasys.ws>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 > This is really a trademark related labelling issue. The trademark
 > allows Linus or his assignee to specify in what way Linux (tm) may
 > be used in labelling and advertising. Linux is just like other
 > products with third-party parts and supplies. If Linus's assignee
 > (Linux international?) where to specify explicit guidelines then
 > people would know what to expect. Something like:
 >
 > Linux certified:
 >     The mainline kernel has a driver and it has been certified
 >     as functioning with this hardware by OSDL or some other
 >     officially sanctioned lab.
 >
 > Linux supported:
 >     The mainline kernel has a driver.

Fine so far.

 > Linux compatible:
 >     Source code driver is available as a patch.

In other words, if a patch is available for the 1.0.0 kernel, they
can claim "Linux compatible" ??? That's meaningless...replace with
something like...

   Linux 2.2.2 compatible:
       Source code driver is available as a patch for the stated
       mainline kernel.

...with the specific version to be made explicit. As a minimum, it
needs to state the actual kernel series the patch is for.

 > Runs on Linux:
 >     A binary only driver is available that can be used with
 >     mainline kernel.

Similar comments apply. Again, require that the kernel that driver
works with is made explicit.

 > Supports Linux:
 >     A portion of the purchase price will be donated to
 >     Linux International.

So a company provides a product for $5,000.00 and donates $0.01 of
the purchase price to the specified organisation, thus entitling
themselves to say "Supports Linux" by this rule. Can I suggest
this alternative definition:

   Supports Linux:
       At least 1% of the purchase price will be donated to
       Linux International.

 > You will notice this all relates to mainline kernels (Linus and
 > Marcello). If the product requires a vendor kernel they need to
 > negotiate with the vendor to say so.

Agreed.

 > These are just suggestions.  Many other products (including MS
 > windows) have similar labelling restrictions, often with logos.
 > Use of the term "Linux" in packaging or advertising or products
 > inconsistent with the official designations would be trademark
 > infringement.

Agreed.

 > Different rules would apply to products that exist strictly in
 > user-space.

That's not necessary - just define:

   Runs under Linux:
       This product work on a system based on a mainline Linux
       kernel without making any modification to the kernel
       itself or loading any kernel modules.

That is all that is required there.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.481 / Virus Database: 277 - Release Date: 13-May-2003

