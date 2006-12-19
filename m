Return-Path: <linux-kernel-owner+w=401wt.eu-S1755140AbWLSCaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbWLSCaf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 21:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbWLSCaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 21:30:35 -0500
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:34088
	"EHLO echohome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbWLSCa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 21:30:26 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 21:30:26 EST
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: <linux-kernel@vger.kernel.org>
Subject: Odd system lock up
Date: Mon, 18 Dec 2006 21:24:52 -0500
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAICP4fRQtKBOo0M5d3WXPNMBAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccW8xK06JwT7hYFQjKz2fcjau+/mAAZ/kmwAu5Z4lA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, got the 2.6.19 kernel installed and running OK, full libata wrapping of
existing IDE controllers and hard disks.

I'm experiencing some odd, random periodic system lockups without any sort
of debugging information being captured in the system message log.  Perhaps
it's a hard disk that's causing the trouble?

Is there a way to capture which drive might be causing the issue in the
message log?

