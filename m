Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135609AbRDXNgT>; Tue, 24 Apr 2001 09:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135614AbRDXNgD>; Tue, 24 Apr 2001 09:36:03 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9463 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135609AbRDXNfq>; Tue, 24 Apr 2001 09:35:46 -0400
From: Christoph Rohland <cr@sap.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: David Woodhouse <dwmw2@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
Organisation: SAP LinuxLab
Date: 24 Apr 2001 15:34:08 +0200
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
Message-ID: <m3n196v2un.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Tue, 24 Apr 2001, Alexander Viro wrote:
> So yes, IMO having such patches available _is_ a good thing. And in
> 2.5 we definitely want them in the tree. If encapsulation part gets
> there during 2.4 and separate allocation is available for all of
> them it will be easier to do without PITA in process.

OK I will do that for tmpfs soon. And I will do the symlink inlining
with that patch.

Greetings
		Christoph


