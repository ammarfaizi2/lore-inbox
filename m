Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSBOA7H>; Thu, 14 Feb 2002 19:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBOA66>; Thu, 14 Feb 2002 19:58:58 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:7178
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285747AbSBOA6r>; Thu, 14 Feb 2002 19:58:47 -0500
Date: Thu, 14 Feb 2002 19:33:29 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: CML2-2.3.0 is available
Message-ID: <20020214193329.A23463@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.

Release 2.3.0: Thu Feb 14 19:20:38 EST 2002
	* Resync with 2.5.4, 2.5.4-dj1 and 2.4.18-pre9.
	* `menus' and `explanations' declarations are gone from the language;
	  all prompts and help info are declared by `symbols` declarations
	  now.
	* Partial fixes to support autoconfigure on Sparc by Mike Cramer.

This doesn't include Linus's 2.5.5-pre1 changes, so it won't configure
ALSA.  I'll fold those in when the ALSA stuff shows up in Dave Jones's
tree. 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
