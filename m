Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTFRUXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbTFRUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:23:47 -0400
Received: from palrel10.hp.com ([156.153.255.245]:46998 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265486AbTFRUWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:22:01 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.52524.806566.75946@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 13:35:56 -0700
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, roland@redhat.com
Subject: Re: common name for the kernel DSO
In-Reply-To: <20030618203247.GA14124@mars.ravnborg.org>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
	<20030618203247.GA14124@mars.ravnborg.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 22:32:47 +0200, Sam Ravnborg <sam@ravnborg.org> said:

  Sam> I see no clean way to share the rules between the architectures,
  Sam> at least not without doing something very special for this.

Yes.  I think that's OK.

  Sam> The second best alternative is to have the same implementation
  Sam> in all architectures supporting this, so my vote goes for the
  Sam> gate name.

OK, noted.

	--david
